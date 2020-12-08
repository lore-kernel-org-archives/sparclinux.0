From: Anatoly Pugachev <matorola@gmail.com>
Date: Tue, 08 Dec 2020 00:33:50 +0000
Subject: Re: [sparc64] current git kernel networking is broken
Message-Id: <CADxRZqyD1rYOtB8AEtLEhvuXc9-hKq0nLrMXZWNECk98GitiJQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CADxRZqwn0uUi+J3bN=uLYMpXYhcYpkQb68Vkgmg70Tn87mhzOw@mail.gmail.com>
In-Reply-To: <CADxRZqwn0uUi+J3bN=uLYMpXYhcYpkQb68Vkgmg70Tn87mhzOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sparc kernel list <sparclinux@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: debian-sparc <debian-sparc@lists.debian.org>, Linux Kernel list <linux-kernel@vger.kernel.org>

On Tue, Dec 8, 2020 at 3:09 AM Anatoly Pugachev <matorola@gmail.com> wrote:
> bisected kernel to the following commit:
>
> linux-2.6$ git bisect good
> fdf8bee96f9aeaac4559725c2dfae6e1bd7b7043 is the first bad commit

forgot to add, that reverting this commit, fixes networking for me.
