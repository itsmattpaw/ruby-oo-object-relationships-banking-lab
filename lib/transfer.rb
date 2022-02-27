class Transfer
  attr_accessor :status
  attr_reader :sender, :receiver, :amount
  
  def initialize(sender, receiver, amt)
    @sender = sender
    @receiver = receiver
    @amount = amt
    @status = "pending"
  end
  def valid?
    if sender.valid? && receiver.valid?
      return true
    else  
      return false
    end
  end
  def execute_transaction
    if valid?
      if sender.balance >= @amount
        if @status == "pending"
          sender.deposit(-@amount)
          receiver.deposit(@amount)
          @status = "complete"
        end
      else
        @status = "rejected"
        "Transaction rejected. Please check your account balance."
      end
    else  
      @status = "rejected"
      "Transaction rejected. Please check your account balance."
    end 
  end
  def reverse_transfer
    if @status == "complete"
      sender.deposit(@amount)
      receiver.deposit(-@amount)
      @status = "reversed"
    end
  end
end
