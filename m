From: David Miller <davem@davemloft.net>
Date: Thu, 05 Sep 2013 19:15:10 +0000
Subject: Re: [PATCH] sparc: fix PCI device proc file mmap(2)
Message-Id: <20130905.151510.260299779851532507.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Alexey Dobriyan <adobriyan@gmail.com>
Date: Tue, 20 Aug 2013 22:17:24 +0300

> Commit 786d7e1612f0b0adb6046f19b906609e4fe8b1ba "Fix rmmod/read/write races in /proc entries"
> must have broken mmapping of PCI device proc files on Sparc.
> 
> Notice how it adds wrapper around ->mmap but doesn't do it around ->get_unmapped_area.
> Add wrapper around ->get_unmapped_area.
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

Applied, thanks for following up on this.
