From: David Miller <davem@davemloft.net>
Date: Sun, 20 Nov 2011 18:16:54 +0000
Subject: Re: 3.2.0-rc2+git: possible recursive locking detected in process
Message-Id: <20111120.131654.558900872365363228.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1111201817070.20433@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1111201817070.20433@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Sun, 20 Nov 2011 18:51:20 +0200 (EET)

> 
> This todays git kernel on Sun Fire V100. It gives the locking warning on 
> bootup but seems to work fine otherwise (apt-get dist-upgrade saw no 
> problems). It did not happen on a very similar Netra X1 but the kernel 
> conf might have been different there (have not verified).

Please report this to the proper block layer maintainers and lkml.

There have been no substantial sparc specific changes in the kernel,
especially not those that could have caused these crashes you are
seeing.

Please treat sparc on equal standing as other platforms, and report
the crashes you encouter the same as if you had seem them on i386
or x86_64.
