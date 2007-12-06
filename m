From: "Pieter D.J. Krul" <p@krul.cc>
Date: Thu, 06 Dec 2007 18:38:54 +0000
Subject: Re: SunOS/Solaris Binary Emulation
Message-Id: <475841BE.9000205@krul.cc>
List-Id: <sparclinux.vger.kernel.org>
References: <475825D7.1090209@dalsemi.com>
In-Reply-To: <475825D7.1090209@dalsemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Jan Engelhardt wrote:
>> manhack:/usr/gnemul/solaris/bin# ldd ./uname
>> /usr/bin/ldd: line 117: ./uname: No such file or directory
> 
> I suppose you need the Solaris libraries too, including dynamic
> linker. See output of `readelf -d uname`.

I tend to agree. All SunOS and Solaris binaries, libraries and devicefiles are by default expected
to exist in /usr/gnemul/sunos and/or /usr/gnemul/solaris.

I've scribbled a few things on this topic some time ago, which should have become a sort of
faq/howto at that time. You can find this on http://www.krul.cc/~pkrul/docs/solemu/

HTH

Pieter
