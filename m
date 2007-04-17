From: "Adam Kropelin" <akropel1@rochester.rr.com>
Date: Tue, 17 Apr 2007 03:35:56 +0000
Subject: Re: [TESTERS NEEDED]: Rewritten ESP driver
Message-Id: <073101c780a1$823f3960$84163e05@kroptech.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20070412.233350.41640545.davem@davemloft.net>
In-Reply-To: <20070412.233350.41640545.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:
> From: "Adam Kropelin" <akropel1@rochester.rr.com>
> Date: Mon, 16 Apr 2007 18:58:39 -0400
>
>> Starting smartd: esp: esp0: Aborting command [fffff80030b05280:2a]
>> esp: esp0: Active command [fffff80030b05280:2a]
>> esp: esp0: Aborting command [fffff80030b05280:00]
>> esp: esp0: Queued command [fffff80030b05280:00]
>> esp: esp0: Aborting command [fffff80030b05280:00]
>> esp: esp0: Queued command [fffff80030b05280:00]
>
> Let's see what the heck smartd is sending to the device.  Please
> reboot with smartd enabled and post the logs that get output
> from this patch below applied, thanks.

Here it is:

Starting smartd:
ESP: SMARTD tgt[1] lun[0] scsi_cmd [ 28 00 01 c4 91 70 00 00 08 00 ]
ESP: SMARTD tgt[1] lun[0] scsi_cmd [ 28 00 01 c4 92 18 00 00 40 00 ]
ESP: SMARTD tgt[1] lun[0] scsi_cmd [ 12 00 00 00 24 00 ]
ESP: SMARTD tgt[1] lun[0] scsi_cmd [ 00 00 00 00 00 00 ]
ESP: SMARTD tgt[1] lun[0] scsi_cmd [ 1a 00 1c 00 40 00 ]
ESP: SMARTD tgt[1] lun[0] scsi_cmd [ 1a 00 5c 00 40 00 ]
ESP: SMARTD tgt[1] lun[0] scsi_cmd [ 4d 00 40 00 00 00 00 00 04 00 ]
ESP: SMARTD tgt[1] lun[0] scsi_cmd [ 4d 00 40 00 00 00 00 00 10 00 ]
ESP: SMARTD tgt[1] lun[0] scsi_cmd [ 4d 00 6f 00 00 00 00 00 04 00 ]
ESP: SMARTD tgt[1] lun[0] scsi_cmd [ 4d 00 6f 00 00 00 00 00 0a 00 ]
ESP: SMARTD tgt[1] lun[0] scsi_cmd [ 03 00 00 00 12 00 ]
esp: esp0: Aborting command [fffff80030b05d00:2a]
esp: esp0: Active command [fffff80030b05d00:2a]
esp: esp0: Aborting command [fffff80030b05d00:00]
esp: esp0: Queued command [fffff80030b05d00:00]
esp: esp0: Aborting command [fffff80030b05d00:00]
esp: esp0: Queued command [fffff80030b05d00:00]
sd 0:0:1:0: rejecting I/O to offline device
sd 0:0:1:0: rejecting I/O to offline device
Buffer I/O error on device sda4, logical block 0
lost page write due to I/O error on sda4
Buffer I/O error on device sda4, logical block 1
lost page write due to I/O error on sda4
sd 0:0:1:0: rejecting I/O to offline device
Buffer I/O error on device sda4, logical block 1029

On one boot smartd actually started correctly and the system booted 
without error. Here is the dump from that success case:

Starting smartd:
ESP: SMARTD tgt[1] lun[0] scsi_cmd [ 28 00 01 c4 91 70 00 00 08 00 ]
ESP: SMARTD tgt[1] lun[0] scsi_cmd [ 28 00 01 c4 92 58 00 00 90 00 ]
ESP: SMARTD tgt[1] lun[0] scsi_cmd [ 28 00 01 c4 91 30 00 00 40 00 ]
ESP: SMARTD tgt[1] lun[0] scsi_cmd [ 28 00 01 c4 91 78 00 00 a0 00 ]
ESP: SMARTD tgt[1] lun[0] scsi_cmd [ 28 00 01 c4 92 18 00 00 40 00 ]
ESP: SMARTD tgt[1] lun[0] scsi_cmd [ 28 00 01 c1 93 d8 00 00 08 00 ]
ESP: SMARTD tgt[1] lun[0] scsi_cmd [ 12 00 00 00 24 00 ]
ESP: SMARTD tgt[1] lun[0] scsi_cmd [ 00 00 00 00 00 00 ]
ESP: SMARTD tgt[1] lun[0] scsi_cmd [ 1a 00 1c 00 40 00 ]
ESP: SMARTD tgt[1] lun[0] scsi_cmd [ 1a 00 5c 00 40 00 ]
ESP: SMARTD tgt[1] lun[0] scsi_cmd [ 4d 00 40 00 00 00 00 00 04 00 ]
ESP: SMARTD tgt[1] lun[0] scsi_cmd [ 4d 00 40 00 00 00 00 00 10 00 ]
ESP: SMARTD tgt[1] lun[0] scsi_cmd [ 4d 00 6f 00 00 00 00 00 04 00 ]
ESP: SMARTD tgt[1] lun[0] scsi_cmd [ 4d 00 6f 00 00 00 00 00 0a 00 ]
ESP: SMARTD tgt[1] lun[0] scsi_cmd [ 03 00 00 00 12 00 ]
ESP: SMARTD tgt[1] lun[0] scsi_cmd [ 4d 00 4d 00 00 00 00 00 04 00 ]
ESP: SMARTD tgt[1] lun[0] scsi_cmd [ 4d 00 4d 00 00 00 00 00 10 00 ]
ESP: SMARTD tgt[1] lun[0] scsi_cmd [ 4d 00 6f 00 00 00 00 00 04 00 ]
ESP: SMARTD tgt[1] lun[0] scsi_cmd [ 4d 00 6f 00 00 00 00 00 0a 00 ]
ESP: SMARTD tgt[1] lun[0] scsi_cmd [ 03 00 00 00 12 00 ]
ESP: SMARTD tgt[1] lun[0] scsi_cmd [ 4d 00 4d 00 00 00 00 00 04 00 ]
ESP: SMARTD tgt[1] lun[0] scsi_cmd [ 4d 00 4d 00 00 00 00 00 10 00 ]
[  OK  ]

--Adam

