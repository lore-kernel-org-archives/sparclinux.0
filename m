From: David Miller <davem@davemloft.net>
Date: Wed, 30 Aug 2017 01:07:56 +0000
Subject: Re: RFC: Driver for Oracle Data Analytics Accelerator
Message-Id: <20170829.180756.1600681260100967541.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1504049763-51918-1-git-send-email-rob.gardner@oracle.com>
In-Reply-To: <1504049763-51918-1-git-send-email-rob.gardner@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Rob Gardner <rob.gardner@oracle.com>
Date: Tue, 29 Aug 2017 17:36:01 -0600

> Any and all feedback welcome and appreciated.

So basically binary blobs will be passed into this driver, and there
will be no verification or documentation of the various DAX
operations, their parameters, what operation they perform, how they
work, and their how their references to the user's buffers operate?

Right?

Sorry, no way.

