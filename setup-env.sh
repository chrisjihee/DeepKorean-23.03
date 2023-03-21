#!/bin/bash
# Tested on Ubuntu 20.04

# 1. uneditable library
export PROJECT_NAME="DeepKorean-23.03"
export PYTHON_VER="3.10"
export CUDA_VER="11.7"
conda update -n base -c defaults conda -y
conda create -n $PROJECT_NAME python=$PYTHON_VER -y
conda activate $PROJECT_NAME
conda install cuda-nvcc=$CUDA_VER cudatoolkit=$CUDA_VER -c nvidia -y
pip install --upgrade torch --index-url https://download.pytorch.org/whl/cu117
pip install --upgrade evaluate datasets tokenizers matplotlib
pip install --upgrade notebook ipython ipynbname ipywidgets jupyterlab tornado==6.1

# 2. editable library
rm -rf transformers lightning chrisbase chrislab ratsnlp flask-ngrok
git clone https://github.com/chrisjihee/transformers.git   # OR https://github.com/huggingface/transformers.git
git clone https://github.com/chrisjihee/lightning.git      # OR https://github.com/Lightning-AI/lightning.git
git clone https://github.com/chrisjihee/chrisbase.git
git clone https://github.com/chrisjihee/chrislab.git
git clone https://github.com/chrisjihee/ratsnlp.git
git clone https://github.com/chrisjihee/flask-ngrok.git
pip install --editable transformers
pip install --editable lightning[extra]
pip install --editable chrisbase
pip install --editable chrislab
pip install --editable ratsnlp
pip install --editable flask-ngrok

# 3. pretrained model (optional)
export DOWNLOAD_ONLINE_MODEL=true
if [ $DOWNLOAD_ONLINE_MODEL = true ]
then
  mkdir -p model/pretrained
  sudo apt install git-lfs  # for sudo user only
  git lfs install
  git clone https://huggingface.co/beomi/kcbert-base                        model/pretrained/KcBERT-Base
  git clone https://huggingface.co/beomi/KcELECTRA-base-v2022               model/pretrained/KcELECTRA-Base
  git clone https://huggingface.co/skt/kobert-base-v1                       model/pretrained/KoBERT-Base
  git clone https://huggingface.co/monologg/koelectra-base-v3-discriminator model/pretrained/KoELECTRA-Base
  git clone https://github.com/KPFBERT/kpfbert                              model/pretrained/KPF-BERT-Base
  git clone https://huggingface.co/klue/bert-base                           model/pretrained/KLUE-BERT-Base
  git clone https://huggingface.co/klue/roberta-base                        model/pretrained/KLUE-RoBERTa-Base
  git clone https://huggingface.co/bert-base-multilingual-uncased           model/pretrained/Google-BERT-Base
  git clone https://huggingface.co/monologg/kobigbird-bert-base             model/pretrained/KoBigBird-Base
else
  mkdir -p model
  git clone guest@129.254.164.137:git/pretrained-com model/pretrained
fi

# 4. ngrok (optional): https://dashboard.ngrok.com/get-started/setup
mkdir -p ngrok
cd ngrok
wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz
tar zxf ngrok-v3-stable-linux-amd64.tgz
mv ngrok ngrok3
cd ..
