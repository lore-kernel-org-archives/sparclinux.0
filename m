From: William Lee Irwin III <wli@holomorphy.com>
Date: Thu, 23 Dec 2004 03:23:17 +0000
Subject: Re: [sparc32] vm fault code handling
Message-Id: <20041223032317.GX771@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20041222143113.GT771@holomorphy.com>
In-Reply-To: <20041222143113.GT771@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Dec 22, 2004 at 06:31:13AM -0800, William Lee Irwin III wrote:
>> Convert arch/sparc/mm/fault.c to symbolic fault codes, default to minor
>> faults for unrecognized fault codes. Also treat VM_FAULT_OOM similarly
>> to VM_FAULT_SIGBUS in force_user_fault(), thereby fixing a latent bug.
>> 
>> [ ... snip patch ... ]

On Wed, Dec 22, 2004 at 05:38:36PM -0600, Art Haas wrote:
> Here's a slightly modified version of that patch which makes the sparc32
> code more closely match the sparc64 code by setting the default branch
> of the case statement to BUG(). The rest of the patch matched what was
> posted above.

I considered that, flipped a coin, and went with defaulting to minor
faults. Since someone has an opinion (though not necessarily strong)
I'll switch it over to that way.


-- wli
