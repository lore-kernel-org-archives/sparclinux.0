From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Tue, 06 Apr 2004 20:35:24 +0000
Subject: Re: [TEST THIS] sparc32 swap fix
Message-Id: <20040406203524.GA26900@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040406044441.GB17154@foobazco.org>
In-Reply-To: <20040406044441.GB17154@foobazco.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Apr 06, 2004 at 02:57:11PM -0500, Art Haas wrote:

> Was the cause of the swap space failures due to changes applied to the
> kernel source between -rc releases and the final release? Enquiring
> minds want to know and learn ...

Yes.  See
http://linux.bkbits.net:8080/linux-2.5/cset@1.1764?nav=index.html|src/|src/mm|related/mm/swapfile.c.

-- 
Keith M Wesolowski
