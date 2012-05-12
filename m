From: David Miller <davem@davemloft.net>
Date: Sat, 12 May 2012 07:15:03 +0000
Subject: Re: PATCH [0/14] sparc32: removal of sun4c platform support
Message-Id: <20120512.031503.1352386667863345201.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120511213143.GA1518@merkur.ravnborg.org>
In-Reply-To: <20120511213143.GA1518@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 12 May 2012 09:00:03 +0200

> Hi David et al.
>> 
>> This opens up some exciting possibilities, for example we
>> can also ditch Cypress sun4m support and therefore eliminate
>> the software integer multiply/divide stuff and thus build
>> the kernel with -mcpu=v8 or similar.
> 
> According to this wikipedia article:
> 
>      http://en.wikipedia.org/wiki/SPARCstation
> 
> Then Cypres is only used in:
> 
> o SPARCstation 2
> o SPARCserver 6xxMP
> 
> I do not own any of these - and I have not
> seen anyone around that uses any of these.

The Cypress chips come on MBUS modules so they can be installed in
SS10, SS20, et al.  I know, because I had 4 or 5 of these cpus boards
and tested them mostly in SS10 pizza boxes.
