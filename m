From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Wed, 10 May 2006 11:41:49 +0000
Subject: Re: Question on cross-compiler
Message-Id: <Pine.LNX.4.10.10605101238360.15487-100000@mtfhpc.demon.co.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <DA6197CAE190A847B662079EF7631C06015691BD@OEKAW2EXVS03.hbi.ad.harman.com>
In-Reply-To: <DA6197CAE190A847B662079EF7631C06015691BD@OEKAW2EXVS03.hbi.ad.harman.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


See http://kegel.com and look for 'crosstool'. The last version I
downloaded was crosstool-0.35.

Dan Kegel has done exstensive cross compilation in the past.

I used his scripts as the basis of my cross compilation scripts for
building Sparc32 code on my AMD64 Linux system.

(It takes too long on Sparc32.)

Regards
	Mark Fortescue.

On Tue, 9 May 2006, Jurzitza, Dieter wrote:

> Dear listmembers,
> is there anyone out who could give me a hint on how to build a cross-compiler for Ultra Sparc 64 Bit on a native 32 Bit environment? My build always barfs about incompatible libc.so - what is clear since it is 32 and not 64 Bit.
> Any pointer to some FAQ / whatsoever would be highly appreciated!
> Thanks in advance,
> take care
> 
> 
> 
> Dieter Jurzitza
> 
> 
> *******************************************
> Diese E-Mail enthaelt vertrauliche und/oder rechtlich geschuetzte Informationen. Wenn Sie nicht der richtige Adressat sind oder diese E-Mail irrtuemlich erhalten haben, informieren Sie bitte sofort den Absender und loeschen Sie diese Mail. Das unerlaubte Kopieren sowie die unbefugte Weitergabe dieser Mail ist nicht gestattet.
>  
> This e-mail may contain confidential and/or privileged information. If you are not the intended recipient (or have received this e-mail in error) please notify the sender immediately and delete this e-mail. Any unauthorized copying, disclosure or distribution of the contents in this e-mail is strictly forbidden.
> *******************************************
> 
> -
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

