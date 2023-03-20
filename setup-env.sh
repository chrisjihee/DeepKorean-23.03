#!/bin/bash
# 1. reset
export PROJECT_NAME="DeepKorean-23.03"
export PYTHON_VER="3.10"
export CUDA_VER="11.7"
conda update -n base -c defaults conda -y
conda create -n $PROJECT_NAME python=$PYTHON_VER -y
conda activate $PROJECT_NAME
conda install cuda-nvcc=$CUDA_VER cudatoolkit=$CUDA_VER -c nvidia -y

# 2. uneditable library
pip install --upgrade torch --index-url https://download.pytorch.org/whl/cu117
pip install --upgrade deepspeed  # Linux
pip install --upgrade evaluate datasets tokenizers matplotlib
pip install --upgrade notebook ipython ipynbname jupyterlab tornado==6.1
pip list --format=freeze >requirements.txt
pip install -r requirements.txt

# 3. editable library
rm -rf transformers lightning chrisdict chrisbase chrislab ratsnlp
git clone https://github.com/chrisjihee/transformers.git
git clone https://github.com/chrisjihee/lightning.git
git clone https://github.com/chrisjihee/chrisdict.git
git clone https://github.com/chrisjihee/chrisbase.git
git clone https://github.com/chrisjihee/chrislab.git
git clone https://github.com/chrisjihee/ratsnlp.git
pip install --editable transformers
pip install --editable lightning[extra]
pip install --editable chrisdict
pip install --editable chrisbase
pip install --editable chrislab
pip install --editable ratsnlp

# 4. pretrained model
export IN_ETRI=true
if [ $IN_ETRI = true ]
then
  mkdir -p model
  git clone guest@129.254.164.137:git/pretrained-com model/pretrained
else
  mkdir -p model/pretrained
  sudo apt install git-lfs
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
fi
