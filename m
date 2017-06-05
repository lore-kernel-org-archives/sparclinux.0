From: Pasha Tatashin <pasha.tatashin@oracle.com>
Date: Mon, 05 Jun 2017 04:00:07 +0000
Subject: Re: [v1 2/6] sparc64: access tick function from variable
Message-Id: <1a720e45-acd8-3fde-6af1-b4ded9dffd78@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1496428854-936411-3-git-send-email-pasha.tatashin@oracle.com>
In-Reply-To: <1496428854-936411-3-git-send-email-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> For the tick read itself itt's probably time for code patching, and
> thus taking the number of loads down to one.

Hi Dave,

True, we could save one more load, by patching tick_get_tick() but that 
would save us only 3-5 instructions because with the changes done in 
this patchset the extra load comes from the same cacheline as the other 
two variables: offset and quotient. So overall, we still have 3 loads as 
before, but they are much faster compared to what we have now, where 
every load is from a different cacheline.

Pasha

