From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Wed, 12 May 2004 14:17:42 +0000
Subject: Re: 2.4.26 on UP sun4m: ksymoops for kernel NULL pointer dereference
Message-Id: <20040512141742.GA22405@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040511122855.A11421@fw.j-son.org>
In-Reply-To: <20040511122855.A11421@fw.j-son.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, May 11, 2004 at 12:28:55PM +0200, Christian Joensson wrote:

> Instruction DUMP: 80a46000  0280001c  01000000 <d0044000> d2020000  80a24018  02800012  213f8c7b  a0142188 
> 
> >>PC;  fe316458 <[jbd]__kstrtab_journal_blocks_per_page+8/28>   <==> >>O7;  f0050a44 <filp_open+2c/54>
> >>I7;  fe32d750 <[ext3].text.start+86f0/eb4f>
> Trace; fe32d750 <[ext3].text.start+86f0/eb4f>
> Trace; f006852c <__mark_inode_dirty+3c/ac>

Unfortunately this trace looks bogus.  Specifically the actual pc
value at time of exception isn't being correctly looked up.  Since
it's in a module, you'll have to try manually looking it up in
/proc/ksyms.  If it really is within the kstrtab, something has gone
horribly wrong long before the MNA.

> Code;  fe316458 <[jbd]__kstrtab_journal_blocks_per_page+8/28>   <==>    c:   d0 04 40 00       ld  [ %l1 ], %o0   <==
The instruction decode is ok, and consistent with the regs.  You might
try looking for the instruction sequence in that module if ksyms isn't
helpful.

-- 
Keith M Wesolowski
