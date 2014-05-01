From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 01 May 2014 16:19:03 +0000
Subject: Re: [PATCH 0/10] Sparc64 MM bug fixes
Message-Id: <20140501161903.GB17134@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20140430.175420.1944889075484067093.davem@davemloft.net>
In-Reply-To: <20140430.175420.1944889075484067093.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Apr 30, 2014 at 05:54:20PM -0400, David Miller wrote:
> 
> This is the current state of my audit of the sparc64 mm code.
> 
> Some of these changes have to do with THP, but some do not.
> 
> I've started to add some better checking of page table sanity,
> in the hopes that it will potentially help further diagnosis
> of any problems that still can be triggered.
Impressive serie - it must have cost a few cups of espresso or the like.
Only one small nit - which is another way to say that I could not follow
all the changes.

See separate mail.

	Sam
