From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Thu, 23 Jun 2016 19:44:30 +0000
Subject: Re: Please upgrade your machines to sparc64
Message-Id: <d9e55cee-2ed3-3341-6fda-e6183b0bb734@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <756b931c-35f9-e094-94bf-f12839b61d92@physik.fu-berlin.de>
In-Reply-To: <756b931c-35f9-e094-94bf-f12839b61d92@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 06/23/2016 09:42 PM, chase rayfield wrote:
> Just to clarify, unlike variable length ISAs Sparc has fixed 32bit and
> 64bit ISAs... Sparc v8+ is 32bits for every instruction executed while
> for Sparc v9 it is 64bits for every instruction. Thus the overhead is
> not just in pointers etc.. as is often the case on variable length
> architectures. 64bit instructions potentially waste more cache as well
> as use 2x the memory bandwidth. Also note that Sparc does not mix
> 32bit and 64bit instructions I presume that when a 64bit kernel is
> executing 32bit code it switches back out of 64bit mode when returning
> to userland...

Then please go to Oracle and tell them they are all wrong with what they
are doing. Because it seems you know more about this stuff than the people
who are engineering the actual hardware.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
