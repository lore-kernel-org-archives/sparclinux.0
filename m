From: "Adam Kropelin" <akropel1@rochester.rr.com>
Date: Mon, 16 Apr 2007 22:58:39 +0000
Subject: Re: [TESTERS NEEDED]: Rewritten ESP driver
Message-Id: <06af01c7807a$c598a830$84163e05@kroptech.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20070412.233350.41640545.davem@davemloft.net>
In-Reply-To: <20070412.233350.41640545.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

David Miller wrote:
> From: "Adam Kropelin" <akropel1@rochester.rr.com>
> Date: Sun, 15 Apr 2007 12:03:26 -0400
>
>> ESP: data done csr[a6400310] flgs[1] sent[73728]
>> ESP: start data addr[c004c000] len[0] write(1)
>> esp: esp0: DMA error, csr=A440031e
>
> I know what this bug is, it should be fixed by the following patch,
> please give it a try.

That works very nicely! I can now boot right up until smartd is=20
launched. Disabling smartd allows a complete boot and the disk survives=20
some beating with concurrent 'tar -x'.

Spot mentioned smartd being problematic with the old esp driver, too.=20
dmesg is below, if it's of interest. I wasn't able to find an=20
illuminating esp_debug setting that didn't result in an overabundance of=20
output, so this is with no esp_debug.

--Adam

scsi0 : esp
esp: esp0 found at /sbus@1f,0/espdma@e,8400000/esp@e,8800000,=20
regs[1ffe8800000:1ffe8400000] irq[10]
esp: esp0 is a FAS100A, 40 MHz (ccf=3D0), SCSI ID 7
scsi 0:0:1:0: Direct-Access     FUJITSU  MAJ3182M SUN18G  0804 PQ: 0=20
ANSI: 2
 target0:0:1: Beginning Domain Validation
 target0:0:1: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset 15)
 target0:0:1: Domain Validation skipping write tests
 target0:0:1: Ending Domain Validation
<...>
Starting mDNSResponder... [  OK  ]
Starting smartd: esp: esp0: Aborting command [fffff80030b05280:2a]
esp: esp0: Active command [fffff80030b05280:2a]
esp: esp0: Aborting command [fffff80030b05280:00]
esp: esp0: Queued command [fffff80030b05280:00]
esp: esp0: Aborting command [fffff80030b05280:00]
esp: esp0: Queued command [fffff80030b05280:00]
sd 0:0:1:0: rejecting I/O to offline device
Buffer I/O error on device sda4, logical block 487611
lost page write due to I/O error on sda4
sd 0:0:1:0: rejecting I/O to offline device
Buffer I/O error on device sda4, logical block 0
lost page write due to I/O error on sda4
Buffer I/O error on device sda4, logical block 1
lost page write due to I/O error on sda4
sd 0:0:1:0: rejecting I/O to offline device
Buffer I/O error on device sda4, logical block 1029
lost page write due to I/O error on sda4
sd 0:0:1:0: rejecting I/O to offline device
Buffer I/O error on device sda4, logical block 327766
lost page write due to I/O error on sda4
sd 0:0:1:0: rejecting I/O to offline device
Buffer I/O error on device sda4, logical block 426011
lost page write due to I/O error on sda4
sd 0:0:1:0: rejecting I/O to offline device
Buffer I/O error on device sda4, logical block 458752
lost page write due to I/O error on sda4
Buffer I/O error on device sda4, logical block 458753
lost page write due to I/O error on sda4
Buffer I/O error on device sda4, logical block 458754
lost page write due to I/O error on sda4
sd 0:0:1:0: rejecting I/O to offline device
Buffer I/O error on device sda4, logical block 458789
lost page write due to I/O error on sda4
sd 0:0:1:0: rejecting I/O to offline device
sd 0:0:1:0: rejecting I/O to offline device
<...repeats...>

