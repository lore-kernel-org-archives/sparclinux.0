From: David Miller <davem@davemloft.net>
Date: Wed, 24 May 2006 06:24:46 +0000
Subject: Re: 2.6.17-rc3+git seems to corrupt dpkg databases
Message-Id: <20060523.232446.85689175.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0605151108040.27015@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0605151108040.27015@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jurij Smakov <jurij@wooyd.org>
Date: Tue, 23 May 2006 22:32:03 -0700 (PDT)

> From a quick look at the code (dpkg-1.13.19), it appears that the status 
> file is mmap'ed for reading with
> 
> mmap(NULL, stat.st_size, PROT_READ, MAP_SHARED, fd, 0)
> 
> at lib/parse.c:114. When the database is written to disk, it is 
> constructed line by line, which are written out to disk using fputs()
> at lib/dump.c:306. The file is fflush'ed and fsync'ed after writing.

This means it's probably a D-cache aliasing issue.  I'll try to figure
it out, thanks.
