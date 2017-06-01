From: Aleksa Sarai <asarai@suse.de>
Date: Thu, 01 Jun 2017 20:00:17 +0000
Subject: Re: [PATCH] tty: add TIOCGPTPEER ioctl
Message-Id: <a0671efc-4c4e-bbdc-c9d8-a7bdc22b872a@suse.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20170601173803.8698-1-asarai@suse.de>
 <CAMuHMdXkaWg70OidDi0_xALbzwZ+o0eEVEzT5U_6HdewBs4WwA@mail.gmail.com>
In-Reply-To: <CAMuHMdXkaWg70OidDi0_xALbzwZ+o0eEVEzT5U_6HdewBs4WwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Arnd Bergmann <arnd@arndb.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, alpha <linux-alpha@vger.kernel.org>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, Parisc List <linux-parisc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Linux-sh list <linux-sh@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>, Linux-Arch <linux-arch@vger.kernel.org>, Christian Brauner <christian.brauner@ubuntu.com>, Valentin Rothberg <vrothberg@suse.com>

>> --- a/arch/alpha/include/uapi/asm/ioctls.h
>> +++ b/arch/alpha/include/uapi/asm/ioctls.h
>> @@ -94,6 +94,7 @@
>>   #define TIOCSRS485     _IOWR('T', 0x2F, struct serial_rs485)
>>   #define TIOCGPTN       _IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
>>   #define TIOCSPTLCK     _IOW('T',0x31, int)  /* Lock/unlock Pty */
>> +#define TIOCGPTPEER    _IOR('T', 0x41, int) /* Safely open the slave */
> 
> Shouldn't the list of definitions be kept sorted, by hex number?
> (everywhere)

Probably. The reason I put it here is because it logically is very 
similar to TIOCGPTN and TIOSPTLCK, but I can move it if the hex order is 
more important for maintainence.

-- 
Aleksa Sarai
Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/
