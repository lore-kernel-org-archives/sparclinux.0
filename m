From: Peter Hurley <peter@hurleysoftware.com>
Date: Wed, 20 Nov 2013 11:50:52 +0000
Subject: Re: RED state exception (trap type 0x64) on U5 reboot
Message-Id: <528CA21C.1020200@hurleysoftware.com>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1310151347070.902@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1310151347070.902@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 11/17/2013 03:35 PM, Meelis Roos wrote:
> This patch seems to switch ldata with its read_buf and echo_buf from
> kmalloc/kfree to vmalloc/vfree (the bufs are now inlined in ldata, not
> separately allocated).
>
> More fields in ldata are now explicitly initialized to zero instead of
> kzalloc doing it before. However, I do not see the initialization of
> some of the fields - maybe they are done later in the code? I noticed
> process_char_map, raw, real_raw, icanon, read_buf, echo_buf that were
> zeroed before but I did not find explicit zeroing of them after the
> patch. However, just adding a memset to zero ldata after vmalloc does
> not change anything.

process_char_map, raw, real_raw & icanon are initialized in the
n_tty_set_termios() called from n_tty_open() where ldata is first allocated.

read_buf is the uninitialized buffer indexed by read_head, canon_head,
read_tail & line_start. echo_buf similarly is uninitialized and indexed by
echo_head, echo_tail & echo_commit.

Regards,
Peter Hurley
