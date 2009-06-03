From: "Hong H. Pham" <hong.pham@windriver.com>
Date: Wed, 03 Jun 2009 16:41:01 +0000
Subject: [PATCH v3 0/1] sparc64: fix and optimize irq distribution
Message-Id: <1244047262-15786-1-git-send-email-hong.pham@windriver.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

Here's a revised patch to fix and optimize interrupt distribution.  The major
change since the last patch is that a tree representation of the CPU hierarchy
is built from the per CPU cpu_data.  Each iteration through the CPU tree
picks the next optimal CPU.  The following are example CPU distribution maps
for various Niagara2/2+ machines.

  T5220 (64 cpus)
  { 0 8 16 24 32 40 48 56 4 12 20 28 36 44 52 60 1 9 17 25 33 41 49 57 5 13 21 29 37 45 53 61 2 10 18 26 34 42 50 58 6 14 22 30 38 46 54 62 3 11 19 27 35 43 51 59 7 15 23 31 39 47 55 63}

  T5440 (2 way, 96 cpus)
  { 0 8 16 24 32 40 72 80 88 96 104 112 4 12 20 28 36 44 76 84 92 100 108 116 1 9 17 25 33 41 73 81 89 97 105 113 5 13 21 29 37 45 77 85 93 101 109 117 2 10 18 26 34 42 74 82 90 98 106 114 6 14 22 30 38 46 78 86 94 102 110 118 3 11 19 27 35 43 75 83 91 99 107 115 7 15 23 31 39 47 79 87 95 103 111 119}

  LDOM (on a T5220)
  { 0 3 1 4 2 5 0 6}

An assumption used when building the CPU tree is that cpu_data is sorted
by node, core_id, and proc_id (in order of significance).  This the case
for the Niagara2 machines I have available.  If this isn't true for all
sparc64 machines, a copy of cpu_data would need to be sorted prior to
building the CPU tree.

Regards,
Hong

