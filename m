From: Steven Rostedt <rostedt@goodmis.org>
Date: Fri, 21 Dec 2018 19:29:09 +0000
Subject: Re: [for-next][PATCH 06/24] sparc64: Use ftrace_graph_get_ret_stack() instead of curr_ret_stack
Message-Id: <20181221142909.0b905cbc@gandalf.local.home>
List-Id: <sparclinux.vger.kernel.org>
References: <20181221175618.968519903@goodmis.org>
        <20181221175656.191575102@goodmis.org>
        <20181221.102414.1992688460948808079.davem@davemloft.net>
In-Reply-To: <20181221.102414.1992688460948808079.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, akpm@linux-foundation.org, namhyung@kernel.org, mhiramat@kernel.org, sparclinux@vger.kernel.org

On Fri, 21 Dec 2018 10:24:14 -0800 (PST)
David Miller <davem@davemloft.net> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> Date: Fri, 21 Dec 2018 12:56:24 -0500
> 
> > From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> > 
> > The structure of the ret_stack array on the task struct is going to
> > change, and accessing it directly via the curr_ret_stack index will no
> > longer give the ret_stack entry that holds the return address. To access
> > that, architectures must now use ftrace_graph_get_ret_stack() to get the
> > associated ret_stack that matches the saved return address.
> > 
> > Cc: sparclinux@vger.kernel.org
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>  
> 
> Acked-by: David S. Miller <davem@davemloft.net>

Thanks David!

-- Steve
