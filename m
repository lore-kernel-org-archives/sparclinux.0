From: Bastian Blank <waldi@debian.org>
Date: Mon, 02 Feb 2009 13:34:13 +0000
Subject: Re: make ARCH=sparc allmodconfig change
Message-Id: <20090202133413.GA21476@wavehammer.waldi.eu.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20090201190029.GA8962@x200.localdomain>
In-Reply-To: <20090201190029.GA8962@x200.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Feb 03, 2009 at 12:24:55AM +1100, Julian Calaby wrote:
> I believe that powerpc also works in this manner, as does x86.

No. Only x86 does this for backward compatibility. Neither s390 nor
powerpc allows such arch overrides.

Bastian

-- 
Captain's Log, star date 21:34.5...
