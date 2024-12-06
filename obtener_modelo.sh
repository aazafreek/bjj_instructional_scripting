[ ! -d ./model ] && mkdir ./model/
wget https://alphacephei.com/vosk/models/vosk-model-small-en-us-0.15.zip -o ./model/vosk-model.zip
mv model/vosk-model.zip /tmp/gen-subs/models/
unzip /tmp/gen-subs/models/*.zip
