From: David Miller <davem@davemloft.net>
Date: Tue, 25 Sep 2018 03:22:52 +0000
Subject: Re: [PATCH] sparc64: viohs: Remove VLA usage
Message-Id: <20180924.202252.1960552216624164256.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20180905220351.GA48213@beast>
        <CAGXu5jL4q_FRn7ehDy4MtXpHanhtsu9M_RGKQMZ+by+Rq9ncKw@mail.gmail.com>
In-Reply-To: <CAGXu5jL4q_FRn7ehDy4MtXpHanhtsu9M_RGKQMZ+by+Rq9ncKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: keescook@chromium.org
Cc: allen.pais@oracle.com, pombredanne@nexb.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>
Date: Mon, 24 Sep 2018 20:17:55 -0700

> On Wed, Sep 5, 2018 at 3:03 PM, Kees Cook <keescook@chromium.org> wrote:
>> In the quest to remove all stack VLA usage from the kernel[1], this
>> allocates a fixed size array for the maximum number of cookies and
>> adds a runtime sanity check.
>>
>> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1
>> RqZWA@mail.gmail.com
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Friendly ping. Dave, can you take this?

I'll try to get to this soon, kinda backlogged at the moment.

Sorry.
