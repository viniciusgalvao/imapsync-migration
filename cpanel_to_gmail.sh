#!/usr/bin/env bash

src_host=''
src_port='993'
src_username=''
src_password=''

dest_host='imap.gmail.com'
dest_port='993'
dest_username=''
dest_password=''

imapsync \
  --host1 "$src_host" --port1 "$src_port" --ssl1 \
  --user1 "$src_username" --password1 "$src_password" \
  --host2 "$dest_host" --port2 "$dest_port" --ssl2 \
  --user2 "$dest_username" --password2 "$dest_password" \
  --exclude 'INBOX.Junk|INBOX.Trash|INBOX.spam' \
  --skipsize &

imapsync \
  --syncinternaldates \
  --host1 "$src_host" --port1 "$src_port" --ssl1 \
  --user1 "$src_username" --password1 "$src_password" \
  --host2 "$dest_host" --port2 "$dest_port" --ssl2 \
  --user2 "$dest_username" --password2 "$dest_password" \
  --useheader 'Message-Id' \
  --skipsize \
  --noauthmd5 \
  --reconnectretry1 1 \
  --reconnectretry2 1 \
  --folder 'INBOX.Sent' --prefix2 '[Gmail]/' --regextrans2 's/Sent$/Sent Mail/' \
  --folder 'INBOX.Deleted Messages' --prefix2 '[Gmail]/' --regextrans2 's/Deleted Messages$/Trash/' \
  --folder 'INBOX.Drafts' --prefix2 '[Gmail]/' --regextrans2 's/INBOX\.Drafts$/Drafts/' &

wait
exit 0
