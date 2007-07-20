From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Fri, 20 Jul 2007 09:55:50 +0000
Subject: Re: Asking for document about booting in sparc
Message-Id: <Pine.LNX.4.61.0707201038400.7051@mtfhpc.demon.co.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <56047.125.212.140.38.1184874205.squirrel@www.cse.hcmut.edu.vn>
In-Reply-To: <56047.125.212.140.38.1184874205.squirrel@www.cse.hcmut.edu.vn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

I currently use the SunOS boot loader because for me it is the least work.

For Linux, most people will probably use silo 
(http://sourceforge.net/projects/silo). If you download the source, you 
can read the documentation there.

For additional sparc information, try www.sun.com (finding anything 
usefull for you may take some time but there is a lot of information there 
for thoes who persist.)

For rearly old sparc systems there may be a limit on the maximum size of 
kernel that can be loaded. For my sun4c systems, the limit is 3MB with 
the SunOS boot loader (4MB-1MB for boot loader). I have seen comments 
about silo that sugest that it thay may have a smaller limit on these 
systems (i.e. silo > 1MB).

Hope this helps.

Regards
 	Mark Fortescue.

On Fri, 20 Jul 2007 dvhung@cse.hcmut.edu.vn wrote:

> I am a newbie, and I am looking for a document about booting in sparc. Is
> there anyone in this mailing list has document(s) related to booting in
> sparc?
> Thank you very much.
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
