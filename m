From: "Wojciech 'Sas' Cieciwa" <cieciwa@alpha.zarz.agh.edu.pl>
Date: Mon, 17 May 2004 08:55:46 +0000
Subject: [SPARC64] Need help..
Message-Id: <Pine.LNX.4.58L.0405171051230.1247@alpha.zarz.agh.edu.pl>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


I try to build kernel 2.6.6 on my machine, but when I build module I got 
some strange message:

  Building modules, stage 2.
  MODPOST
*** Warning: "" [lib/zlib_inflate/zlib_inflate.ko] undefined!
*** Warning: "current_thread_info_reg" [lib/zlib_inflate/zlib_inflate.ko] undefined!
*** Warning: "" [lib/zlib_inflate/zlib_inflate.ko] undefined!
*** Warning: "" [lib/zlib_inflate/zlib_inflate.ko] undefined!
*** Warning: "" [lib/zlib_deflate/zlib_deflate.ko] undefined!
*** Warning: "current_thread_info_reg" [lib/zlib_deflate/zlib_deflate.ko] undefined!
*** Warning: "" [lib/zlib_deflate/zlib_deflate.ko] undefined!
*** Warning: "" [lib/zlib_deflate/zlib_deflate.ko] undefined!
*** Warning: "" [drivers/net/hamradio/yam.ko] undefined!
*** Warning: "" [drivers/net/hamradio/yam.ko] undefined!
*** Warning: "" [drivers/net/hamradio/yam.ko] undefined!
*** Warning: "current_thread_info_reg" [drivers/net/hamradio/yam.ko] undefined!
*** Warning: "" [drivers/md/xor.ko] undefined!
*** Warning: "" [drivers/md/xor.ko] undefined!
*** Warning: "" [drivers/md/xor.ko] undefined!
[...]

This message i teke from all modules which I build.
What's wrong ?
And how to repair this?

Thanx.
					Sas.
-- 
{Wojciech 'Sas' Cieciwa}  {Member of PLD Team                               }
{e-mail: cieciwa@alpha.zarz.agh.edu.pl, http://www2.zarz.agh.edu.pl/~cieciwa}
