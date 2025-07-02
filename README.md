**ML on Edge Devices**

```
curl -O https://dl.google.com/coral/edgetpu_api/edgetpu_runtime_20201204.zip

unzip edgetpu_runtime_20201204.zip

cd edgetpu_runtime

sudo bash install.sh

mkdir google-coral && cd google-coral

git clone https://github.com/google-coral/tflite --depth 1

cd tflite/python/examples/classification

# >>> pyenv setup >>>
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
# <<< pyenv setup <<<

# still in the same terminal, with python --version → 3.8.18
python -m venv --copies coral38        # call the env whatever you like
source coral38/bin/activate

# sanity-check inside the env
python --version                       # 3.8.18
arch                                   # arm64

pip install numpy 
pip install upgrade "Pillow<10"
pip install \
  "https://github.com/google-coral/pycoral/releases/download/v2.0.0/tflite_runtime-2.5.0.post1-cp38-cp38-macosx_12_0_arm64.whl"

python classify_image.py \
  --model models/mobilenet_v2_1.0_224_inat_insect_quant.tflite \
  --labels labels/inat_insect_labels.txt \
  --input images/common-fly.png
```

[USB Accelerator | Coral](https://coral.ai/) 

(https://coral.ai/products/accelerator)


```
docker build -t tpu-compiler .

wget -O mobilenet_v1_50_160_quantized.tflite \https://tfhub.dev/tensorflow/lite-model/\mobilenet_v1_0.50_160_quantized/1/default/1?lite-format=tflite

docker run -it -v ${PWD}:/models tpu-compiler

cd models
ls

edgetpu_compiler --help
edgetpu_compiler mobilenet_v1_50_160_quantized.tflite ```
