From: Kjetil Oftedal <oftedal@gmail.com>
Date: Thu, 13 Jun 2019 22:04:28 +0000
Subject: Re: [PATCH] sparc: Remove redundant copy of the LGPL-2.0
Message-Id: <CALMQjD-dAX8hU6sNxDWtdxc7CddO3KDd9Fu_J74tZ-6pn5_Z5Q@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20190527163253.27203-1-thuth@redhat.com> <20190613.141247.955308190761079084.davem@davemloft.net>
In-Reply-To: <20190613.141247.955308190761079084.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: thuth@redhat.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On 13/06/2019, David Miller <davem@davemloft.net> wrote:
> From: Thomas Huth <thuth@redhat.com>
> Date: Mon, 27 May 2019 18:32:53 +0200
>
>> We already provide the LGPL-2.0 text in LICENSES/preferred/LGPL-2.0,
>> so there is no need for this additional copy here.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>
> Applied.
>

Shouldn't the SPDX license identifiers in in arch/sparc/lib be adjusted to
reflect the original intent of LGPL licensing?

-
Kjetil Oftedal
