From: David Miller <davem@davemloft.net>
Date: Tue, 19 Sep 2017 21:55:15 +0000
Subject: Re: [PATCH] Expose some h/w info from ILOM to userspace via sysfs
Message-Id: <20170919.145515.1711992436941536102.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <baf0b81a-0265-ed20-52c8-e5c558f62c47@oracle.com>
In-Reply-To: <baf0b81a-0265-ed20-52c8-e5c558f62c47@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Eric Saint Etienne <eric.saint.etienne@oracle.com>
Date: Tue, 19 Sep 2017 14:43:56 -0700 (PDT)

> The filtering has been added to avoid leaking confidential details
> such as private keys and passwords.

The set the permissions appropriately on the sysfs files whose node
data contains such values.
