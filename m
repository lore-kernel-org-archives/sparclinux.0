From: Jim Gifford <maillist@jg555.com>
Date: Thu, 30 Mar 2006 05:25:38 +0000
Subject: Re: SCSI Hard Drive Issues Netra
Message-Id: <442B6BD2.9090503@jg555.com>
List-Id: <sparclinux.vger.kernel.org>
References: <442B3557.6090300@jg555.com>
In-Reply-To: <442B3557.6090300@jg555.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Jim Gifford wrote:
> Since I tried working with 2.6.16 and 2.6.16.1, when I attempt to 
> mount my scsi disks, I get invalid disk label. Switch back to 
> 2.6.15.x, and the problem goes away. Any ideas suggestions, I'm stuck 
> at this point to figure out what's wrong. Any help will be appreciated.
>
OK, here's what I've been able to find out about the issue investigating 
it a lot further. Some reason it's saying my drives have an improper 
checksum(See error message below).

I'm doing a build on my X1 to see if the issue also exists.

root:~# fdisk /dev/sda
Detected sun disklabel with wrong checksum.
Probably you'll have to set all the values,
e.g. heads, sectors, cylinders and partitions
or force a fresh label (s command in main menu)


-- 
----
Jim Gifford
maillist@jg555.com

