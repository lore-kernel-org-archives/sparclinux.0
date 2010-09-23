From: "Alex Mach" <alexvm12e@mail.ru>
Date: Thu, 23 Sep 2010 14:54:56 +0000
Subject: Re: Question about interrupt processing on Sparc64
Message-Id: <37F30271D87E401AAB31D1042E43D5E0@alexm>
List-Id: <sparclinux.vger.kernel.org>
References: <E1OymHM-0000pp-00.alexvm12e-mail-ru@f159.mail.ru>
In-Reply-To: <E1OymHM-0000pp-00.alexvm12e-mail-ru@f159.mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


----- Original Message ----- 
From: "Sam Ravnborg" <sam@ravnborg.org>
To: "Alex Mach" <alexvm12e@mail.ru>
Cc: "sparclinux" <sparclinux@vger.kernel.org>
Sent: Thursday, September 23, 2010 6:14 PM
Subject: Re: Question about interrupt processing on Sparc64


> They are both included by: head_64.S

Yes but head_64.S isn't linked too in my case (I use kernel 2.6.30.5). I 
mean there is not head_64.o file after compiling kernel. The file is linked 
using
extra-y     := head_$(BITS).o in Makefle but looks like this string doesn't 
work. Perhaps, I need to set any config options?

Thanks,
Alex. 

