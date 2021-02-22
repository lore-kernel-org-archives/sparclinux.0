From: Anatoly Pugachev <matorola@gmail.com>
Date: Mon, 22 Feb 2021 17:21:31 +0000
Subject: Re: bisected kernel crash on sparc64 with stress-ng
Message-Id: <CADxRZqy8Mhv8EMhDjXLf3npLb14inqPf9Mr-0fVtBg_TPz2XTA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <b7fbbf94-2ac8-8043-b59f-195a3716977f@linux.ee>
In-Reply-To: <b7fbbf94-2ac8-8043-b59f-195a3716977f@linux.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Feb 22, 2021 at 7:21 PM Rob Gardner <rob.gardner@oracle.com> wrote:
>
> Can you have stress-ng print out the random opcodes as it runs? That
> might give a hint about where things are going wrong.

Rob,

there's quite a few different ones on my tests, please see [1], [2]

1. https://www.spinics.net/lists/sparclinux/msg25915.html
2. https://www.spinics.net/lists/sparclinux/msg25917.html
