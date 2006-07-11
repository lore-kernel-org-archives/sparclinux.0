From: Raymond Burns <rayburns@comcast.net>
Date: Tue, 11 Jul 2006 02:33:01 +0000
Subject: Re: sparc-2.6.git sparc32
Message-Id: <Pine.LNX.4.10.10607101926560.4657-200000@coalcreekmill.cm.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="279707904-1182501875-1152585181=:4657"
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.10.10607081238470.30008-200000@coalcreekmill.cm.com>
In-Reply-To: <Pine.LNX.4.10.10607081238470.30008-200000@coalcreekmill.cm.com>
To: sparclinux@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--279707904-1182501875-1152585181=:4657
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi

Your patch worked well, Thank You

For the sun4d I had to remove the arc specific local_irq_enable() to
allow the mainline initialization to occur, which seems to work.


On Sat, 8 Jul 2006, Bob Breuer wrote:

> I'm seeing the same thing.
> 
> Based on sparc64, it should be possible to defer the initialization of
> the mostek clock until later.
> 
> The attached patch gets me past the clock driver, but it ends up with a
> watchdog reset after switching to malloc:
> 
>   io scheduler cfq registered (default)
>   ioremap: done with statics, switching to malloc
> 
>   Watchdog Reset
>   Type  help  for more information
>   <#0> ok
> 
> Bob
> 

Thanx
  Ray


--279707904-1182501875-1152585181=:4657
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=patch_irq_enable
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.10.10607101933010.4657@coalcreekmill.cm.com>
Content-Description: patch remove arch local_irq_enable
Content-Disposition: attachment; filename=patch_irq_enable

LS0tIHRpbWUuYy5vcmlnCU1vbiBKdWwgMTAgMTc6NDc6MjggMjAwNg0KKysr
IHRpbWUuYwlNb24gSnVsIDEwIDE3OjQ3OjM0IDIwMDYNCkBAIC00MjEsNyAr
NDIxLDYgQEANCiAjZW5kaWYNCiANCiAJLyogTm93IHRoYXQgT0JQIHRpY2tl
ciBoYXMgYmVlbiBzaWxlbmNlZCwgaXQgaXMgc2FmZSB0byBlbmFibGUgSVJR
LiAqLw0KLQlsb2NhbF9pcnFfZW5hYmxlKCk7DQogfQ0KIA0KIHZvaWQgX19p
bml0IHRpbWVfaW5pdCh2b2lkKQ0K
--279707904-1182501875-1152585181=:4657--
