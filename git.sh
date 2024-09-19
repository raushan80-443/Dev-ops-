
email = "raushan120189@gamil.com"
username = "raushan80-443"
ssh-keygen -t rsa -b 4096 -C $email

eval "$(ssh-agent -s)"

cat ~/.ssh/id_rsa.pub

