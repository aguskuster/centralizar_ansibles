echo "[BkBases]" >> /etc/samba/smb.conf
echo "comment = directorio compartido con samba" >> /etc/samba/smb.conf
echo "path = /home/back/BkBases">> /etc/samba/smb.conf
echo "valid users = back">> /etc/samba/smb.conf
echo "public = no" >> /etc/samba/smb.conf
echo "writable = yes" >> /etc/samba/smb.conf