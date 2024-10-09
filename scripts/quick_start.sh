if [ ! -f assets/infore/hifigan/g_01140000 ]; then
  echo "Downloading models..."
  mkdir -p assets/infore/{nat,hifigan}
  wget https://huggingface.co/ntt123/viettts_infore_16k/resolve/main/duration_latest_ckpt.pickle -O assets/infore/nat/duration_latest_ckpt.pickle
  wget https://huggingface.co/ntt123/viettts_infore_16k/resolve/main/acoustic_latest_ckpt.pickle -O assets/infore/nat/acoustic_latest_ckpt.pickle
  wget https://huggingface.co/ntt123/viettts_infore_16k/resolve/main/g_01140000 -O assets/infore/hifigan/g_01140000
  cf_file=$(realpath assets/hifigan/config.json)
  ckp_file=$(realpath assets/infore/hifigan/g_01140000)
  python3 -m vietTTS.hifigan.convert_torch_model_to_haiku --config-file=$cf_file --checkpoint-file=$ckp_file
fi

echo "Generate audio clip"
text=`cat assets/transcript.txt`
python3 -m vietTTS.synthesizer --text "$text" --output assets/infore/clip.wav --lexicon-file assets/infore/lexicon.txt --silence-duration 0.2
