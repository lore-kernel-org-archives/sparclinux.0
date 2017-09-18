From: David Miller <davem@davemloft.net>
Date: Mon, 18 Sep 2017 16:45:22 +0000
Subject: Re: [PATCH] Expose some h/w info from ILOM to userspace via sysfs
Message-Id: <20170918.094522.564342283929263646.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <baf0b81a-0265-ed20-52c8-e5c558f62c47@oracle.com>
In-Reply-To: <baf0b81a-0265-ed20-52c8-e5c558f62c47@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Eric Saint Etienne <eric.saint.etienne@oracle.com>
Date: Mon, 18 Sep 2017 15:27:45 +0100

> I doubt that a blob model like /dev/mdesc is better since it's not
> the approach that has been used in the kernel. You can convince
> yourself of this by looking at where lshw gets most if its data:
> from sysfs. That's because kernel developers before us (since 2.4
> when sysfs has been introduced, really) have decided to expose
> things on sysfs rather then via blobs. So sysfs is definitely the
> way to go.

If some small library converts the blob into hierachical tree of text
objects, _WHAT_ is the difference?

We don't export things multiple ways form the kernel.

We have an existing mechanism for mdesc export, please use it.
