From: David Miller <davem@davemloft.net>
Date: Wed, 19 Jun 2019 13:57:14 +0000
Subject: Re: [PATCH] sparc: Remove redundant copy of the LGPL-2.0
Message-Id: <20190619.095714.256356699322316004.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <CALMQjD-dAX8hU6sNxDWtdxc7CddO3KDd9Fu_J74tZ-6pn5_Z5Q@mail.gmail.com>
        <20190613.151456.1482983218638838740.davem@davemloft.net>
        <20190619075342.GA11485@yogzotot>
In-Reply-To: <20190619075342.GA11485@yogzotot>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: matorola@gmail.com
Cc: oftedal@gmail.com, thuth@redhat.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, pombredanne@nexb.com, kstewart@linuxfoundation.org

From: Anatoly Pugachev <matorola@gmail.com>
Date: Wed, 19 Jun 2019 10:53:42 +0300

> Update arch/sparc/lib/* to LGPL-2.0+ to be in order with original arch/sparc/lib/COPYING.LIB
> 
> sed -i 's/SPDX-License-Identifier: \(.*\) */SPDX-License-Identifier: LGPL-2.0+ *\//' arch/sparc/lib/*
> 
> Fixes: b24413180f56 ("License cleanup: add SPDX GPL-2.0 license identifier to files with no license")
> Signed-off-by: Anatoly Pugachev <matorola@gmail.com>

Looks good.
