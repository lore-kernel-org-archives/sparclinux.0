From: "Eric Brower" <ebrower@gmail.com>
Date: Thu, 07 Sep 2006 03:48:28 +0000
Subject: Re: Fw: [Bugme-new] [Bug 7115] New: openpromfs on 2.6.18-rc stop working
Message-Id: <ec7cefb0609062048l6346b2b3n2fae24c1798dac9a@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20060906202247.6e609ed7.akpm@osdl.org>
In-Reply-To: <20060906202247.6e609ed7.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This seems to be a known issue, as per DaveM's last changelog for
fs/openpromfs/inode.c:

diff-tree 3d824a4... (from 87b385d...)
Author: David S. Miller <davem@davemloft.net>
Date:   Sun Jun 25 23:19:14 2006 -0700

    [OPENPROMFS]: Rewrite using in-kernel device tree and seq_file.

    We lose property writing functionality for the time being, but
    that will be easy to add back.  The code and framework is so
    much simpler now.

    Signed-off-by: David S. Miller <davem@davemloft.net>

:100644 100644 efc7c91... 93a56bd... M  fs/openpromfs/inode.c

I'm not sure if these dates correspond with post-2.6.17.11, but that
would be my impression.

Thanks,
E

On 9/6/06, Andrew Morton <akpm@osdl.org> wrote:
>
> We seem to have a regression, and David is out of town.
>
> Begin forwarded message:
>
> Date: Wed, 6 Sep 2006 13:36:49 -0700
> From: bugme-daemon@bugzilla.kernel.org
> To: bugme-new@lists.osdl.org
> Subject: [Bugme-new] [Bug 7115] New: openpromfs on 2.6.18-rc stop working
>
>
> http://bugzilla.kernel.org/show_bug.cgi?idq15
>
>            Summary: openpromfs on 2.6.18-rc stop working
>     Kernel Version: 2.6.18-rc6
>             Status: NEW
>           Severity: normal
>              Owner: platform_sparc64@kernel-bugs.osdl.org
>          Submitter: marvin@mydatex.cz
>
>
> Most recent kernel where this bug did not occur: 2.6.17.11
> Distribution: Debian Sarge
> Hardware Environment: Sun E250
> Software Environment: Sarge
> Problem Description:
> When I try change input device or another prom config param
> I get Invalid argument and kernel returns EINVAL. The same think on 2.6.17.2 works
>
> Steps to reproduce:
> echo "keyboard' > /proc/openprom/options/input-device
> Inavlid argument
>
> ------- You are receiving this mail because: -------
> You are on the CC list for the bug, or are watching someone who is.
> -
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
E
