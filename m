From: David Miller <davem@davemloft.net>
Date: Thu, 01 May 2014 16:48:46 +0000
Subject: Re: [PATCH 09/10] sparc64: Add basic validations to {pud,pmd}_bad().
Message-Id: <20140501.124846.69355078122133318.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20140430.175556.65359624693463383.davem@davemloft.net>
In-Reply-To: <20140430.175556.65359624693463383.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 1 May 2014 18:17:02 +0200

> I assume it is a coincidence that we have the same block size
> in sparc64_valid_addr_bitmapi (22) as we have for REAL_HPAGE_SHIFT.

There is no relation.

I should use a macro for this, for sure.

The short story is that I tried to find a value that tries to be
finely grained enough to handle the smallest SIMM that could be
installed, but no moreso in order to not use more memory than
needed for the bitmap.

There are reasons to revisit this choice too, as the increase to
47 bit physical address support exploded the size of some of these
tables.

Thanks.
