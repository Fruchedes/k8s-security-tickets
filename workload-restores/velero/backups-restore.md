Backup and Restore Using Velero

Backing Up:
Create a Backup:


velero create backup my-backup --include-namespaces <namespace>
Replace <namespace> with the name of the namespace you want to back up. Use --include-namespaces '*' to back up all namespaces.
Check Backup Status:


velero get backups
Verify the status of your backup.
Restoring:
Restore from Backup:


velero restore create --from-backup my-backup
Replace my-backup with the name of your backup.
Check Restore Status:


velero get restores
Verify the status of your restore operation.
