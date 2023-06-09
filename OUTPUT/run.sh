#Execute file
#Getting the temporal file name
tmp_folder=$(date +'%Y_%m_%d_%H_%M_%S')

# Creating the tmp file in PROGRM

mkdir PROGRAM/$tmp_folder/
mkdir OUTPUT/


# Enter in PROGRAM folder

cd PROGRAM/

# Execute Makefile to get the last version

make

# Copy the programs and scripts to the tmp folder
# The thing we need start with "r_*"

cp main $tmp_folder/


#Enter in tmp folder

cd $tmp_folder/

#Execute the progrm

./main


# After the program finalizes, we go back

#rm r_*

cd ..
cd ..
mkdir OUTPUT/$tmp_folder/
# We crate the output folder in OUTPUT and copy results

cp PROGRAM/$tmp_folder/* OUTPUT/$tmp_folder/

#Delete the tmp folder from PROGRAM

 cd PROGRAM/
 rm -r $tmp_folder/
# cd ..


# END     ##################################################


