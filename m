From: Jurij Smakov <jurij@wooyd.org>
Date: Wed, 24 May 2006 05:32:03 +0000
Subject: Re: 2.6.17-rc3+git seems to corrupt dpkg databases
Message-Id: <Pine.LNX.4.63.0605232224040.3668@bobcat>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0605151108040.27015@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0605151108040.27015@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, 23 May 2006, David Miller wrote:

> From: Jurij Smakov <jurijus@wooyd.org>
> Date: Tue, 23 May 2006 21:33:25 -0700 (PDT)
>
>> FWIW, I have just reproduced the problem on my Ultra5 running 2.6.17-rc4
>> by trying to install KDE and all dependencies :-(.
>
> How exactly does dpkg access these files (particularly the 'status'
> file)?  It is just normal reads and writes, or does it use mmap()?

From a quick look at the code (dpkg-1.13.19), it appears that the status 
file is mmap'ed for reading with

mmap(NULL, stat.st_size, PROT_READ, MAP_SHARED, fd, 0)

at lib/parse.c:114. When the database is written to disk, it is 
constructed line by line, which are written out to disk using fputs()
at lib/dump.c:306. The file is fflush'ed and fsync'ed after writing.

Best regards,

Jurij Smakov                                        jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                   KeyID: C99E03CC
