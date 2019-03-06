[ "$RUNUSER" = "none" ] && return

if ! whoami &> /dev/null; then
  if [ -w /etc/passwd ]; then
    echo "${RUNUSER}:x:`id -u`:0:OpenShift ${RUNUSER}:$HOME:/bin/bash" >> /etc/passwd
  else
    echo "Failed to update /etc/passwd. Not writable." >&2
  fi

  if [ -w /etc/group ]; then
    echo "${RUNUSER}:x:`id -u`:${RUNUSER}" >> /etc/group
  else
    echo "Failed to update /etc/group. Not writable." >&2
  fi

  if [ -w /etc/shadow ]; then
    echo "${RUNUSER}:!!:17420::::::" >> /etc/shadow
  else
    echo "Failed to update /etc/shadow. Not writable." >&2
  fi
fi
