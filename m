From: Bob <bo-liu@hotmail.com>
Date: Wed, 10 Dec 2008 02:37:36 +0000
Subject: Why need to load %%l0 register during switch_to macro
Message-Id: <COL115-W7714A68DEBC5468C2E0AF59FFB0@phx.gbl>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


HI, all
 
I have another question about switch_to macro.
 
Why need to load %%l0 register during switch_to macro?
 
"ldd [%%sp+0x00], %%l0" 
 
I think load %%i6 is enough.
 
Hoping this time my mail style is correct.
 
Thanks All

---
Best regards

Bob Liu
_________________________________________________________________
News, entertainment and everything you care about at Live.com. Get it now!
http://www.live.com/getstarted.aspx
