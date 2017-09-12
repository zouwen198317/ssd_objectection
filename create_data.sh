cur_dir=$(cd $( dirname ${BASH_SOURCE[0]} ) && pwd )
root_dir=./caffe


# we changed data root dir and data_ser_name and label_type
redo=1
# this is your root data dir
data_root_dir="./data/my_data"
mapfile="./data/my_data/labelmap_kitti.prototxt"


dataset_name="clothes"
anno_type="detection"
label_type="txt"
db="lmdb"
min_dim=0
max_dim=0
width=0
height=0

extra_cmd="--encode-type=jpg --encoded"
if [ $redo ] 
then
  extra_cmd="$extra_cmd --redo"
fi
for subset in test train
do
  python $root_dir/scripts/create_annoset.py --anno-type=$anno_type --label-type=$label_type --label-map-file=$mapfile --min-dim=$min_dim --max-dim=$max_dim --resize-width=$width --resize-height=$height --check-label $extra_cmd . $data_root_dir/$subset.txt $data_root_dir/$db/$dataset_name"_"$subset"_"$db examples/$dataset_name
done