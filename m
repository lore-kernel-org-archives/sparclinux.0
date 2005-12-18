From: "J.O. Aho" <trizt@iname.com>
Date: Sun, 18 Dec 2005 22:03:37 +0000
Subject: Re: Sparc: Kernel 2.6.13 to 2.6.15-rc2 bug when running X11
Message-Id: <Pine.LNX.4.64.0512182257520.11208@lai.local.lan>
List-Id: <sparclinux.vger.kernel.org>
References: <DGEKIABPPPEBAOMKAJCEKEAKCBAA.mark@mtfhpc.demon.co.uk>
 <Pine.LNX.4.64.0512121127240.12856@lai.local.lan> <20051212.142654.62759069.davem@davemloft.net>
In-Reply-To: <20051212.142654.62759069.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: mark@mtfhpc.demon.co.uk, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

On Mon, 12 Dec 2005, David S. Miller wrote:
> From: "J.O. Aho" <trizt@iname.com>

Hi Miller,

>> I have been using gcc-3.3.5 (64bits) when building the kernel, today
>> I did upgrade to gcc-3.3.6 (64bits), but still have the same problem
>> with the X11.  For build normal system applications and tools I have
>> gcc-3.3.6 (32bit).
> I use gcc-4.0.2 and gcc-3.4.5 for all of my kernel builds.

I have tried gcc-3.4.5, but still I have a process that can lock the 
console totally if you run something that looks into the /proc specially 
the process after X itself (that one can't be kill). So I wonder if you do 
use some patches for gcc or do you use the "vanilla" gcc?


-- 
      //Aho

  ------------------------------------------------------------------------
   E-Mail: trizt@iname.com            URL: http://www.kotiaho.net/~trizt/
      ICQ: 13696780
   System: Linux System                        (PPC7447/1000 AMD K7A/2000)
  ------------------------------------------------------------------------
             EU forbids you to send spam without my permission
  ------------------------------------------------------------------------
