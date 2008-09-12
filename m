From: David Miller <davem@davemloft.net>
Date: Fri, 12 Sep 2008 21:44:06 +0000
Subject: Re: Processor IDs on the Niagara
Message-Id: <20080912.144406.227523219.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <48CADADA.7050604@uwaterloo.ca>
In-Reply-To: <48CADADA.7050604@uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Elad Lahav <elahav@uwaterloo.ca>
Date: Fri, 12 Sep 2008 17:10:50 -0400

> I have a question regarding the meaning of cpu_data.proc_id.  My
> T1000 contains a single T1 processor, with 8 cores and 4 threads per
> core. The core_id value for each hardware thread is set up properly
> (though starting from 1 rather than 0). The proc_id value, however,
> does not make sense: it maps to core_id - 1.

This is the correct setting.

The kernel treats core_id=0 as special, therefore we start the
indexes there at "1".

The kernel treats proc_id=-1 as special, therefore we start those
indexes at "0".

This is why we initialize core_id=0 and prof_id=-1 before we are
able to figure out what the values should be.

This is what other ports do.
