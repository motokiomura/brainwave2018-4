FILE_NAME=$1
processing-java --sketch=$PWD/samples/osc_event_sample/ --run $FILE_NAME
python $PWD/recommend/recommend_sample.py $PWD/samples/osc_event_sample/$FILE_NAME.csv
