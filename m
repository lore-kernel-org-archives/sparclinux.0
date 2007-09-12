From: =?ISO-8859-1?Q?Iv=E1n_Chavero?= <ichavero@uach.mx>
Date: Wed, 12 Sep 2007 20:31:29 +0000
Subject: Re: AW: SILO problem on a T1000
Message-Id: <46E84CA1.4030202@uach.mx>
List-Id: <sparclinux.vger.kernel.org>
References: <46E6F95E.9080204@uach.mx>
In-Reply-To: <46E6F95E.9080204@uach.mx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I've tried with all the partitions of that disk a thru h:
/pci@7c0/pci@0/pci@8/scsi@2/disk@0,0
/pci@7c0/pci@0/pci@8/scsi@2/disk@0,0:a
/pci@7c0/pci@0/pci@8/scsi@2/disk@0,0:b
/pci@7c0/pci@0/pci@8/scsi@2/disk@0,0:c
...

and get the same error:



Rebooting with command: boot disk:a
Boot device: /pci@7c0/pci@0/pci@8/scsi@2/disk@0,0:a  File and args:
The file just loaded does not appear to be executable.

I don't really know what is wrong here.



Jurzitza, Dieter wrote:
> Hi Ivan,
> from what I read from your mail and given that /dev/sda1 is your root partition (containing /boot as well) I'd guess that you ought to test (in openboot):
> 
> probe-scsi-all
> 
> You are trying to boot like:
> 
> Boot device: /pci@7c0/pci@0/pci@8/scsi@2/disk@0,0
> 
> this refers to the SCSI ID 0 on controller 2 but you do not specify the apropriate partition. So what you need to test is:
> 
> probe-scsi-all
> 
> what ought to give you something like
> 
> /pci@1f,4000,scsi@3,1
> Target 1
> Unit 0 Disk IBM DGVS09U 03B0
> 
> /pci@1f,4000,scsi@3
> Target 6
> Unit 0 Removable Read Only device
> 
> If you want to boot of one of those you hafe to specify:
> boot /pci@1f,4000,scsi@3,1/disk@1,0:f (harddisk)
> 
> boot /pci@1f,4000,scsi@3,1/disk@6,0:f (cdrom)
> 
> This gives:
> -> pci - device at 1f, 4000
> 
> scsi@3,1	*external* Controller channel
> 
> disk@1     harddisk with scsi-id 1
> 
> ,0         LUN 0
> 
> :f         Partition F
> 
> this can constantly be integrated by setting
> nvalias /pci@1f,4000,scsi@3,1/disk@1,0:f extdisk
> 
> being "extdisk" an example. The variables can be printed via the command "devalias"
> 
> In general: Strg-P returns the last commandline in openboot (as "little" help).
> 
> Hope this helps,
> take care
> 
> 
> 
> Dieter Jurzitza
> 


-- 
Ivan Chavero
Administrador de Sistemas UNIX
Universdad Autonoma de Chihuahua
ichavero@uach.mx
614 439 18 35 ext 1728
http://www.uach.mx
