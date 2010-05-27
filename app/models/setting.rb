class Setting < ActiveRecord::Base
    def choice_value(value)
        s=""
        values.each do |val|
            s+= "{" if val == value
            s+= val
            s+= "}" if val == value
            s+= "|" unless val == values.last
        end
        s
    end

    def values
        output=[]
        self.value.split("|").map { |value| output.push(value.gsub(/\{(.*?)\}/,'\1')) }
        output
    end

    def selected
        output=""
        self.value.split("|").each do |value|
            output = value.gsub(/\{(.*?)\}/,'\1') if value =~ /\{(.*?)\}/
        end
        output
    end
end
