From: Mikael Pettersson <mikpelinux@gmail.com>
Date: Thu, 03 Aug 2017 20:02:57 +0000
Subject: Re: strace-4.18 test suite oopses sparc64 4.12 and 4.13-rc kernels
Message-Id: <22915.33137.173101.458489@gargle.gargle.HOWL>
List-Id: <sparclinux.vger.kernel.org>
References: <CADxRZqzkUqWsHgw8eNHF4E_wi5a6d=hJnmEtm5omsw42tHAw+Q@mail.gmail.com>
        <20170731.145151.571917275997786929.davem@davemloft.net>
        <CADxRZqz+oQn8=Q3RDtfko9ctP1RE41XnsVP3H8RXJuE9m=VPLw@mail.gmail.com>
        <20170731.150632.885106324164202893.davem@davemloft.net>
        <22912.11736.664315.645426@gargle.gargle.HOWL>
        <20170801205829.GA7496@ravnborg.org>
        <20170802213647.GA5506@ravnborg.org>
In-Reply-To: <20170802213647.GA5506@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Mikael Pettersson <mikpelinux@gmail.com>, David Miller <davem@davemloft.net>, matorola@gmail.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

Sam Ravnborg writes:
 > On Tue, Aug 01, 2017 at 10:58:29PM +0200, Sam Ravnborg wrote:
 > > Hi Mikael.
 > > 
 > > I think this translates to the following code
 > > from linux/uaccess.h
 > > 
 > > first part is the inlined _copy_from_user()
 > > 
 > > > 
 > > > (gdb) x/10i do_sys_poll+0x80-16
 > > >    0x516ed0 <do_sys_poll+112>:  brz  %o0, 0x5170fc <do_sys_poll+668>
 > > if (unlikely(res))
 > > 
 > > >    0x516ed4 <do_sys_poll+116>:  mov  %o0, %o2
 > > >    0x516ed8 <do_sys_poll+120>:  sub  %i4, %o0, %i4
 > > >    0x516edc <do_sys_poll+124>:  clr  %o1
 > > >    0x516ee0 <do_sys_poll+128>:  call  0x7570b8 <memset>
 > > >    0x516ee4 <do_sys_poll+132>:  add  %l3, %i4, %o0
 > > memset(to + (n - res), 0, res);
 > 
 > And memset calls down to bzero, where %o0=buf, %o1=len
 > 
 > %o0 = 0xc
 > %o1 = 0xfff000123c897a80
 > %o2 = 0x0
 > %o3 = 0xc
 > 
 > So from this we know that:
 > res = 0xfff000123c897a80
 > to + (n - 0xfff000123c897a80)) = 0xc
 > 
 > The value "fff000123c897a80" really looks like a constructed address
 > from somewhere in the strace code, and where this constructed address
 > is used to provoke some unusual behaviour.
 > The "fff0" part may be a sparc thing.
 > 
 > So far the analysis seems to match the intial conclusion that
 > we in this special case try to zero out the remaining memory
 > based on the return value of raw_copy_from_user.
 > And therefore we use the return value (res) which triggers the oops.
 > 
 > So rather than manipulating with the assembler code as suggested
 > in the previous mail this simpler patch could be tested:
 > 
 > diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
 > index acdd6f915a8d..13d299ff1f21 100644
 > --- a/include/linux/uaccess.h
 > +++ b/include/linux/uaccess.h
 > @@ -115,7 +115,7 @@ _copy_from_user(void *to, const void __user *from, unsigned long n)
 >  		res = raw_copy_from_user(to, from, n);
 >  	}
 >  	if (unlikely(res))
 > -		memset(to + (n - res), 0, res);
 > +		void: /*memset(to + (n - res), 0, res);*/
 >  	return res;
 >  }
 >  #else
 > 
 > 
 > It would be good to know if this makes the opps go away.
 > 
 > And maybe you could try to print the parameters
 > supplied to _copy_from_user in case memset would be called,
 > so we have an idea what error path is taken.
 > 
 > I have tried to dechiper U3memcpy.S - but that is non-trivial.
 > So it would be good with a bit more data to verify the theory.

I applied the following:

--- linux-4.13-rc3/include/linux/uaccess.h.~1~  2017-08-01 08:49:48.397819726 +0200
+++ linux-4.13-rc3/include/linux/uaccess.h      2017-08-03 21:33:11.009634421 +0200
@@ -4,6 +4,8 @@
 #include <linux/sched.h>
 #include <linux/thread_info.h>
 #include <linux/kasan-checks.h>
+#include <linux/ratelimit.h>
+#include <linux/printk.h>
 
 #define VERIFY_READ 0
 #define VERIFY_WRITE 1
@@ -115,7 +117,9 @@ _copy_from_user(void *to, const void __u
                res = raw_copy_from_user(to, from, n);
        }
        if (unlikely(res))
-               memset(to + (n - res), 0, res);
+       {
+               printk_ratelimited("_copy_from_user(%p, %p, %lu) res %lu\n", to, from, n, res);
+       }
        return res;
 }
 #else

With that in place the kernel booted fine.
When I then ran the `poll' strace test binary, the OOPS was replaced by:

[  140.589913] _copy_from_user(fff000123c8dfa7c,           (null), 240) res 240
[  140.753162] _copy_from_user(fff000123c8dfa7c, 00000000f7e4a000, 8) res 8
[  140.824155] _copy_from_user(fff000123c8dfa7c, 00000000f7e49ff8, 16) res 18442240552407530112

That last `res' doesn't look good.

/Mikael
