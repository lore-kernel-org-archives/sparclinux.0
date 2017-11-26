From: chase rayfield <cusbrar1@gmail.com>
Date: Sun, 26 Nov 2017 20:12:49 +0000
Subject: Re: Silo on RAID 1
Message-Id: <CACwypyNCcoa1OouMvsc9dw93CCTYu070v1ETuDEQR6fWkaJpnw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1511689792.4483.9.camel@xs4all.nl>
In-Reply-To: <1511689792.4483.9.camel@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Shouldn't your partition index for silo be 1 if you are following this
guide? Silo counts partitions 1-n not 0-n like grub etc...

https://www.unix.com/linux/141253-sparc-linux-raid1-silo.html

Sorry it took me a bit to get this to go to the list I don't post here
often and the HTML email rejection is pretty stout ha!

Chase Rayfield
